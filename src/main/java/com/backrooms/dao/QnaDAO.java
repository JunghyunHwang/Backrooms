package com.backrooms.dao;

import com.backrooms.dto.ImageFileNamesDTO;
import com.backrooms.dto.ImageInsertDTO;
import com.backrooms.dto.QnaDTO;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@RequiredArgsConstructor
@Repository
public class QnaDAO {

  private final SqlSessionTemplate template;

  public int insert(QnaDTO dto) {
    int check = template.insert("QnaMapper.insert", dto);

    return check;
  }

  public QnaDTO selectOne(int postNum) {
    return template.selectOne("QnaMapper.detail", postNum);
  }

  public int totalCount() {
    return template.selectOne("QnaMapper.totalCount");
  }

  public int totalPendingCount() {
    return template.selectOne("QnaMapper.totalPendingCount");
  }

  public int totalCompletedCount() {
    return template.selectOne("QnaMapper.totalCompletedCount");
  }

  public List<QnaDTO> selectList(int offset, int perPage) {
    List<QnaDTO> qnaList = template.selectList("QnaMapper.list", null, new RowBounds(offset, perPage));
    return qnaList;
  }

  public List<QnaDTO> selectPendingList(int offset, int perPage) {
    List<QnaDTO> qnaList = template.selectList(
      "QnaMapper.selectPendingList",
      null,
      new RowBounds(offset, perPage)
    );
    return qnaList;
  }

  public List<QnaDTO> selectCompletedList(int offset, int perPage) {
    List<QnaDTO> qnaList = template.selectList(
      "QnaMapper.selectCompletedList",
      null,
      new RowBounds(offset, perPage)
    );
    return qnaList;
  }

  public List<QnaDTO> selectMyList(int offset, int perPage, int memberNum) {
    List<QnaDTO> qnaList = template.selectList("QnaMapper.Mylist", memberNum, new RowBounds(offset, perPage));
    return qnaList;
  }

  public int update(QnaDTO dto) {
    return template.update("QnaMapper.update", dto);
  }

  public int delete(List<Integer> idsToDelete) {
    return template.update("QnaMapper.delete", idsToDelete);
  }

  public void saveImage(ImageInsertDTO imageInsertDTO) {
    // TODO Auto-generated method stub
    template.insert("QnaMapper.imageAdd", imageInsertDTO);
  }

  public String getImagesByPostNum(int postNum) {
    // TODO Auto-generated method stub
    return template.selectOne("QnaMapper.getImage", postNum);
  }

  //  All
  public List<QnaDTO> getAllQNAs(int offset, int perPage) {
    return template.selectList("QnaMapper.selectAllQNAs", null, new RowBounds(offset, perPage));
  }

  public int getAllQnAsTotalCount() {
    return template.selectOne("QnaMapper.selectAllQnAsTotalCount");
  }

  public List<QnaDTO> getPendingQNAs(int offset, int perPage) {
    return template.selectList("QnaMapper.selectPendingQNAs", null, new RowBounds(offset, perPage));
  }

  public int getPendingQNAsTotalCount() {
    return template.selectOne("QnaMapper.selectPendingQNAsTotalCount");
  }

  public List<QnaDTO> getCompletedQNAs(int offset, int perPage) {
    return template.selectList("QnaMapper.selectCompletedQNAs", null, new RowBounds(offset, perPage));
  }

  public int getComplectedQNAsTotalCount() {
    return template.selectOne("QnaMapper.selectPendingQNAsTotalCount");
  }

  // Service
  public List<QnaDTO> getAllServices(int offset, int perPage) {
    return template.selectList("QnaMapper.selectAllServices", null, new RowBounds(offset, perPage));
  }

  public int getAllServicesTotalCount() {
    return template.selectOne("QnaMapper.selectAllServicesTotalCount");
  }

  public List<QnaDTO> getPendingServices(int offset, int perPage) {
    return template.selectList("QnaMapper.selectPendingService", null, new RowBounds(offset, perPage));
  }

  public int getPendingServicesTotalCount() {
    return template.selectOne("QnaMapper.selectPendingServicesTotalCount");
  }

  public List<QnaDTO> getCompletedServices(int offset, int perPage) {
    return template.selectList("QnaMapper.selectCompletedServices", null, new RowBounds(offset, perPage));
  }

  public int getCompletedServicesTotalCount() {
    return template.selectOne("QnaMapper.selectCompletedServicesTotalCount");
  }

  //  romm

  public List<QnaDTO> getAllRooms(int offset, int perPage) {
    return template.selectList("QnaMapper.selectAllRooms", null, new RowBounds(offset, perPage));
  }

  public int getAllRoomsTotalCount() {
    return template.selectOne("QnaMapper.selectAllRoomsTotalCount");
  }

  public List<QnaDTO> getPendingRooms(int offset, int perPage) {
    return template.selectList("QnaMapper.selectPendingRooms", null, new RowBounds(offset, perPage));
  }

  public int getPendingRoomsTotalCount() {
    return template.selectOne("QnaMapper.selectPendingRoomsTotalCount");
  }

  public List<QnaDTO> getCompletedRooms(int offset, int perPage) {
    return template.selectList("QnaMapper.selectCompletedRooms", null, new RowBounds(offset, perPage));
  }

  public int getCompletedRoomsTotalCount() {
    return template.selectOne("QnaMapper.selectCompletedRoomsTotalCount");
  }

  // payment

  public List<QnaDTO> getAllPayment(int offset, int perPage) {
    return template.selectList("QnaMapper.selectAllPayment", null, new RowBounds(offset, perPage));
  }

  public int getAllPaymentTotalCount() {
    return template.selectOne("QnaMapper.selectAllPaymentTotalCount");
  }

  public List<QnaDTO> getPendingPayment(int offset, int perPage) {
    return template.selectList("QnaMapper.selectPendingPayment", null, new RowBounds(offset, perPage));
  }

  public int getPendingPaymentTotalCount() {
    return template.selectOne("QnaMapper.selectPendingPaymentTotalCount");
  }

  public List<QnaDTO> getCompletedPayment(int offset, int perPage) {
    return template.selectList("QnaMapper.selectCompletedPayment", null, new RowBounds(offset, perPage));
  }

  public int getCompletedPaymentTotalCount() {
    return template.selectOne("QnaMapper.selectCompletedPaymentTotalCount");
  }

  // refund
  public List<QnaDTO> getAllRefund(int offset, int perPage) {
    return template.selectList("QnaMapper.selectAllRefund", null, new RowBounds(offset, perPage));
  }

  public int getAllRefundTotalCount() {
    return template.selectOne("QnaMapper.selectAllRefundTotalCount");
  }

  public List<QnaDTO> getPendingRefund(int offset, int perPage) {
    return template.selectList("QnaMapper.selectPendingRefund", null, new RowBounds(offset, perPage));
  }

  public int getPendingRefundTotalCount() {
    return template.selectOne("QnaMapper.selectPendingRefundTotalCount");
  }

  public List<QnaDTO> getCompletedRefund(int offset, int perPage) {
    return template.selectList("QnaMapper.selectCompletedRefund", null, new RowBounds(offset, perPage));
  }

  public int getCompletedRefundTotalCount() {
    return template.selectOne("QnaMapper.selectCompletedRefundTotalCount");
  }

  //   rservation
  public List<QnaDTO> getAllReservations(int offset, int perPage) {
    return template.selectList("QnaMapper.selectAllReservations", null, new RowBounds(offset, perPage));
  }

  public int getAllReservationsTotalCount() {
    return template.selectOne("QnaMapper.selectAllReservationsTotalCount");
  }

  public List<QnaDTO> getPendingReservations(int offset, int perPage) {
    return template.selectList("QnaMapper.selectPendingReservations", null, new RowBounds(offset, perPage));
  }

  public int getPendingReservationsTotalCount() {
    return template.selectOne("QnaMapper.selectPendingReservationsTotalCount");
  }

  public List<QnaDTO> getCompletedReservations(int offset, int perPage) {
    return template.selectList("QnaMapper.selectCompletedReservations", null, new RowBounds(offset, perPage));
  }

  public int getCompletedReservationsTotalCount() {
    return template.selectOne("QnaMapper.selectCompletedReservationsTotalCount");
  }

  // etc

  public List<QnaDTO> getAllEtc(int offset, int perPage) {
    return template.selectList("QnaMapper.selectAllEtc", null, new RowBounds(offset, perPage));
  }

  public int getAllEtcTotalCount() {
    return template.selectOne("QnaMapper.selectAllEtcTotalCount");
  }

  public List<QnaDTO> getPendingEtc(int offset, int perPage) {
    return template.selectList("QnaMapper.selectPendingEtc", null, new RowBounds(offset, perPage));
  }

  public int getPendingEtcTotalCount() {
    return template.selectOne("QnaMapper.selectPendingEtcTotalCount");
  }

  public List<QnaDTO> getCompletedEtc(int offset, int perPage) {
    return template.selectList("QnaMapper.selectCompletedEtc", null, new RowBounds(offset, perPage));
  }

  public int getCompletedEtcTotalCount() {
    return template.selectOne("QnaMapper.selectCompletedEtcTotalCount");
  }
}
