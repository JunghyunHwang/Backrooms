package com.backrooms.external;

import com.backrooms.dto.HotelInsert;
import com.backrooms.dto.RoomInsert;
import com.backrooms.service.HotelQueryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.HashMap;
import java.util.Collections;

@Component
public class HotelDataFetcher {
    public static final int DEFAULT_HOTEL_COUNT = 20;
    public static final int DEFAULT_ROOM_COUNT = 3;
    private static final int MAX_HOTEL_IMAGES_COUNT = 3;
    private static final int MAX_ROOM_IMAGES_COUNT = 3;
    private static final int DEFAULT_RADIUS_BY_METERS = 10000;

    private final HotelQueryService hotelQueryService;
    private final ApiKeyProvider apiKeyProvider;

    private final Random random;
    private final List<String> roomNames;
    private final List<String> amenitiesPool;
    private final Map<String, double[]> countryCoordinates;

    @Autowired
    public HotelDataFetcher(HotelQueryService hotelQueryService, ApiKeyProvider apiKeyProvider) {
        this.hotelQueryService = hotelQueryService;
        this.apiKeyProvider = apiKeyProvider;
        this.random = new Random();
        this.roomNames = Arrays.asList(
            "스탠다드 더블룸", "스탠다드 트윈룸", "디럭스 더블룸", "디럭스 트윈룸", "패밀리룸", "로얄 스위트"
        );
        this.amenitiesPool = Arrays.asList(
            "무료 Wi-Fi", "TV", "에어컨", "욕조", "커피포트", "조식 포함", "미니바", "책상", "금연", "룸서비스"
        );

        this.countryCoordinates = new HashMap<>();
        countryCoordinates.put("서울", new double[]{37.5665, 126.9780});
        countryCoordinates.put("베이징", new double[]{39.9042, 116.4074});
        countryCoordinates.put("도쿄", new double[]{35.6895, 139.6917});
        countryCoordinates.put("마닐라", new double[]{14.5995, 120.9842});
        countryCoordinates.put("하노이", new double[]{21.0285, 105.8544});
        countryCoordinates.put("방콕", new double[]{13.7563, 100.5018});
        countryCoordinates.put("뉴델리", new double[]{28.6139, 77.2090});
        countryCoordinates.put("카이로", new double[]{30.0444, 31.2357});
        countryCoordinates.put("런던", new double[]{51.5074, -0.1278});
        countryCoordinates.put("파리", new double[]{48.8566, 2.3522});
        countryCoordinates.put("베를린", new double[]{52.5200, 13.4050});
        countryCoordinates.put("바르셀로나", new double[]{41.3851, 2.1734});
        countryCoordinates.put("로마", new double[]{41.9028, 12.4964});
        countryCoordinates.put("호놀룰루", new double[]{21.3069, -157.8583});
        countryCoordinates.put("뉴욕", new double[]{40.7128, -74.0060});
    }

    @Async
    public void setHotelData() {
        for (String key : countryCoordinates.keySet()) {
            fetchHotelData(key);
        }
    }

    private void fetchHotelData(String cityName) {
        if (!countryCoordinates.containsKey(cityName)) {
            assert(false) : "Wrong city name: " + cityName;
            return;
        }

        double lat = countryCoordinates.get(cityName)[0];
        double lng = countryCoordinates.get(cityName)[1];

        String url = String.format(
            "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%d&type=lodging&language=ko&key=%s",
            lat, lng, DEFAULT_RADIUS_BY_METERS, apiKeyProvider.getGoogleApiKey()
        );

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
        assert(response.getStatusCode() == HttpStatus.OK);
        assert(response.getBody() != null);
        List<Map<String, Object>> results = (List<Map<String, Object>>)response.getBody().get("results");

        List<HotelInsert> hotels = new ArrayList<>(DEFAULT_HOTEL_COUNT);
        for (Map<String, Object> result : results) {
            String name = (String) result.get("name");
            String address = (String) result.get("vicinity");
            Double rating = result.get("rating") != null ? ((Number) result.get("rating")).doubleValue() : null;
            assert(rating != null) : "Rating is null";

            Map<String, Object> geometry = (Map<String, Object>)result.get("geometry");
            Map<String, Object> location = (Map<String, Object>)geometry.get("location");
            String latitude = location.get("lat").toString();
            String longitude = location.get("lng").toString();

            double[] gradeOptions = { 3.0, 3.5, 4.0, 4.5, 5.0 };
            double grade = gradeOptions[random.nextInt(gradeOptions.length)];

            int breakfastPrice = 20000 + random.nextInt(20001);

            List<String> images = fetchHotelImages((String)result.get("place_id"));
            if (images.isEmpty()) {
                continue;
            }
            
            List<RoomInsert> rooms = createRooms();

            hotels.add(new HotelInsert(name, rating, grade, address, cityName, latitude, longitude, breakfastPrice, images, rooms));
        }

        hotelQueryService.insertHotelsAndRooms(hotels);
    }

    private List<String> fetchHotelImages(String placeId) {
        String url = String.format(
            "https://maps.googleapis.com/maps/api/place/details/json?place_id=%s&fields=photos&language=ko&key=%s",
            placeId, apiKeyProvider.getGoogleApiKey()
        );

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);

        List<String> imageUrls = new ArrayList<>();

        Map<String, Object> body = response.getBody();
        if (body != null && body.containsKey("result")) {
            Map<String, Object> result = (Map<String, Object>) body.get("result");
            List<Map<String, Object>> photos = (List<Map<String, Object>>) result.get("photos");

            if (photos != null) {
                for (int i = 0; i < Math.min(photos.size(), MAX_HOTEL_IMAGES_COUNT); ++i) {
                    String photoRef = (String) photos.get(i).get("photo_reference");
                    String photoUrl = String.format(
                        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photo_reference=%s&key=%s",
                        photoRef, apiKeyProvider.getGoogleApiKey()
                    );
                    imageUrls.add(photoUrl);
                }
            }
        }

        return imageUrls;
    }

    private List<RoomInsert> createRooms() {
        int numberOfRoomTypes = DEFAULT_ROOM_COUNT + random.nextInt(roomNames.size() - 2); // 3 ~ roomNames.size()

        // 방 종류 랜덤 3 ~ '방 종류 개수'개 선택
        Collections.shuffle(roomNames);
        List<RoomInsert> result = new ArrayList<>(numberOfRoomTypes);

        for (int i = 0; i < numberOfRoomTypes; ++i) {
            String name = roomNames.get(i);
            int price = 50000 + random.nextInt(350001); // 50,000 ~ 400,000
            int capacity = 2 + random.nextInt(5); // 2 ~ 6
            int availableCount = 2 + random.nextInt(19); // 2 ~ 20

            // 편의시설 랜덤 3~5개 선택
            Collections.shuffle(amenitiesPool);
            List<String> amenities = amenitiesPool.subList(0, 3 + random.nextInt(3));

            RoomInsert room = new RoomInsert(name, price, capacity, String.join("/", amenities), availableCount);
            for (int j = 0; j < MAX_ROOM_IMAGES_COUNT; ++j) {
                room.addImageUrl("https://picsum.photos/seed/room" + random.nextInt(10000) + "/800/600");
            }

            result.add(room);
        }

        return result;
    }

}
