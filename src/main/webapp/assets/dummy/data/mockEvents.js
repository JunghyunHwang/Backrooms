const events = [
  {
    id: 1,
    date: "2025-07-01",
    title: "여름 바캉스 특별 할인",
    location: "서울 강남 호텔",
    organizer: "호텔 마케팅팀",
    content: "7~8월 투숙객 대상 최대 30% 할인! 조식 포함된 스페셜 패키지 제공.",
  },
  {
    id: 2,
    date: "2025-06-15",
    title: "신규 오픈 기념 프로모션",
    location: "부산 해운대 호텔",
    organizer: "홍보팀",
    content: "신규 호텔 오픈 기념, 첫 방문 고객 20% 할인 이벤트 진행.",
  },
  {
    id: 3,
    date: "2025-09-10",
    title: "가을 풍경 특별 패키지",
    location: "제주도 힐링 리조트",
    organizer: "마케팅팀",
    content: "가을 단풍 시즌 맞이 특별 패키지, 무료 스파 포함.",
  },
  {
    id: 4,
    date: "2025-08-20",
    title: "주말 가족 패키지 할인",
    location: "인천 송도 호텔",
    organizer: "영업팀",
    content: "가족 단위 고객 대상 주말 할인 패키지, 키즈 클럽 무료 이용.",
  },
  {
    id: 5,
    date: "2025-12-31",
    title: "연말 파티 & 만찬 이벤트",
    location: "서울 명동 호텔",
    organizer: "이벤트팀",
    content: "연말 맞이 특별 파티 및 만찬, 라이브 밴드 공연 포함.",
  },
  {
    id: 6,
    date: "2025-04-05",
    title: "봄꽃 축제 할인",
    location: "경주 전통호텔",
    organizer: "마케팅팀",
    content: "봄꽃이 만발하는 시즌, 전 객실 25% 할인.",
  },
  {
    id: 7,
    date: "2025-01-01",
    title: "신년 스페셜 프로모션",
    location: "대구 도심 호텔",
    organizer: "호텔 경영팀",
    content: "새해 첫 투숙객 대상, 무료 조식 및 레이트 체크아웃 제공.",
  },
  {
    id: 8,
    date: "2025-05-20",
    title: "럭셔리 스파 패키지",
    location: "서울 강남 럭셔리 호텔",
    organizer: "서비스팀",
    content: "럭셔리 스파와 전용 라운지 이용, 특별 할인 혜택 제공.",
  },
  {
    id: 9,
    date: "2025-03-14",
    title: "한정판 디너 이벤트",
    location: "부산 파라다이스 호텔",
    organizer: "레스토랑팀",
    content: "셰프 특별 메뉴로 구성된 디너 코스, 예약 필수.",
  },
  {
    id: 10,
    date: "2025-02-10",
    title: "비즈니스 고객 특별 할인",
    location: "서울 비즈니스 호텔",
    organizer: "영업팀",
    content: "비즈니스 고객 대상, 회의실 무료 업그레이드 및 할인 혜택 제공.",
  },
  {
    id: 11,
    date: "2025-08-05",
    title: "힐링 주말 패키지",
    location: "제주도 리조트",
    organizer: "마케팅팀",
    content: "주말 동안의 힐링 패키지, 전용 수영장 및 스파 할인 제공.",
  },
  {
    id: 12,
    date: "2025-02-14",
    title: "로맨틱 발렌타인 패키지",
    location: "서울 강남 호텔",
    organizer: "이벤트팀",
    content: "발렌타인데이 맞이 커플 패키지, 디너와 스파 포함.",
  },
  {
    id: 13,
    date: "2025-07-15",
    title: "가족 친화형 주간 할인",
    location: "인천 가족 호텔",
    organizer: "영업팀",
    content: "주간 투숙 고객 대상, 가족실 무료 업그레이드 이벤트.",
  },
  {
    id: 14,
    date: "2025-03-01",
    title: "특별 주중 할인 이벤트",
    location: "대전 도심 호텔",
    organizer: "호텔 마케팅팀",
    content: "주중 투숙객 대상 특별 할인, 무료 조식 제공.",
  },
  {
    id: 15,
    date: "2025-07-25",
    title: "여름 페스티벌 패키지",
    location: "서울 강남 호텔",
    organizer: "이벤트팀",
    content: "여름 페스티벌 기간 한정, 다양한 이벤트와 할인 혜택 제공.",
  },
  {
    id: 16,
    date: "2025-10-05",
    title: "가을 와인 테이스팅 이벤트",
    location: "제주도 와인 호텔",
    organizer: "레스토랑팀",
    content: "와인 애호가를 위한 특별 테이스팅 행사, 할인 혜택 제공.",
  },
  {
    id: 17,
    date: "2025-12-15",
    title: "겨울 스키 & 스파 패키지",
    location: "강원도 스키 리조트",
    organizer: "마케팅팀",
    content: "겨울 스키 시즌 맞이, 스파 할인 패키지와 무료 장비 대여 포함.",
  },
  {
    id: 18,
    date: "2025-06-01",
    title: "신규 리모델링 기념 할인",
    location: "부산 센텀 호텔",
    organizer: "경영팀",
    content: "리모델링 기념, 객실 전면 리뉴얼 할인 이벤트 진행.",
  },
  {
    id: 19,
    date: "2025-09-20",
    title: "문화 체험 패키지",
    location: "서울 종로 호텔",
    organizer: "마케팅팀",
    content: "전통 문화 체험과 함께하는 특별 패키지, 할인 혜택 제공.",
  },
  {
    id: 20,
    date: "2025-05-10",
    title: "스파 & 웰니스 주간 할인",
    location: "인천 해변 호텔",
    organizer: "서비스팀",
    content: "웰니스 프로그램과 스파 이용, 주간 할인 이벤트 진행.",
  },
  {
    id: 21,
    date: "2025-11-01",
    title: "현대 미술 전시 관람 패키지",
    location: "서울 강남 호텔",
    organizer: "이벤트팀",
    content: "현대 미술 전시 관람 티켓 포함, 할인된 패키지 제공.",
  },
  {
    id: 22,
    date: "2025-07-05",
    title: "여름 리조트 빌라 할인",
    location: "제주도 해변 리조트",
    organizer: "영업팀",
    content: "리조트 빌라 예약 시 특별 할인 혜택, 무료 조식 제공.",
  },
  {
    id: 23,
    date: "2025-04-20",
    title: "럭셔리 스위트 오픈 이벤트",
    location: "서울 시티 호텔",
    organizer: "마케팅팀",
    content: "신규 럭셔리 스위트룸 오픈 기념, 한정판 할인 이벤트 진행.",
  },
  {
    id: 24,
    date: "2025-08-30",
    title: "친환경 에코 투어 패키지",
    location: "전주 힐링 호텔",
    organizer: "이벤트팀",
    content: "자연 친화적인 투어와 함께하는 에코 패키지, 할인 혜택 제공.",
  },
  {
    id: 25,
    date: "2025-06-25",
    title: "디너 크루즈 특별 이벤트",
    location: "부산 해운대 호텔",
    organizer: "레스토랑팀",
    content: "부산 해안선 크루즈 디너, 한정 할인 제공.",
  },
  {
    id: 26,
    date: "2025-10-15",
    title: "문화 예술 축제 패키지",
    location: "서울 예술의전당 호텔",
    organizer: "마케팅팀",
    content: "문화 예술 축제 기간 동안 특별 할인 패키지 제공.",
  },
  {
    id: 27,
    date: "2025-03-25",
    title: "주말 스파 리트릿",
    location: "제주도 힐링 리조트",
    organizer: "서비스팀",
    content: "주말 동안 스파 리트릿 패키지, 전용 시설 할인 이벤트 진행.",
  },
  {
    id: 28,
    date: "2025-11-10",
    title: "시즌 한정 조식 할인",
    location: "서울 강남 호텔",
    organizer: "영업팀",
    content: "투숙 고객 대상 조식 할인 이벤트, 한정 기간 제공.",
  },
  {
    id: 29,
    date: "2025-05-30",
    title: "프리미엄 라운지 이용 혜택",
    location: "인천 공항 호텔",
    organizer: "서비스팀",
    content: "프리미엄 라운지 무료 이용과 함께하는 특별 할인 이벤트 진행.",
  },
  {
    id: 30,
    date: "2025-02-20",
    title: "주중 비즈니스 패키지",
    location: "서울 비즈니스 호텔",
    organizer: "영업팀",
    content:
      "비즈니스 고객을 위한 주중 할인 패키지, 회의실 무료 업그레이드 포함.",
  },
];
