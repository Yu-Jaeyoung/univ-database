package customer;

import conf.Conf;
import java.sql.*;

public class UpdateCustomer {
    public static void main(String[] args) {

        Connection conn = null;
        PreparedStatement psmtQuery = null;
        PreparedStatement psmtUpdate = null;

        ResultSet rs = null;

        // 수정할 데이터
        String customerId = "grape";
        int age = 21;
        String grade = "vip";
        int savedMoney = 100000;

        try {
            // 드라이버를 로딩한다.
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // 데이터베이스의 연결을 설정한다.
            conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD);
            conn.setAutoCommit(false); // 하나의 트랜잭션으로 묶음
            // conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);

            // 고객 정보가 있는지 확인한다

            String query = "select customer_id from customer where customer_id = ?";
            psmtQuery = conn.prepareStatement(query);
            psmtQuery.setString(1, customerId);
            rs = psmtQuery.executeQuery();

            if (!rs.next()) {    // 고객 정보가 존재하지 않으면
                System.err.println("에러: 아이디가 존재하지 않습니다.");
            } else {
                String updateStatement = "UPDATE customer SET age = ?, grade = ?, saved_money = ? WHERE customer_id = ?";
                psmtUpdate = conn.prepareStatement(updateStatement);

                psmtUpdate.setInt(1, age);
                psmtUpdate.setString(2, grade);
                psmtUpdate.setInt(3, savedMoney);
                psmtUpdate.setString(4, customerId);
                psmtUpdate.executeUpdate();

                System.out.println(customerId + "의 정보가 수정되었습니다.");

                // System.in.read(); // 트랜잭션 확인용

                conn.commit();
            }
        } catch (Exception e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            e.printStackTrace();
        } finally {
            try {
                // ResultSet를 닫는다.
                if (rs != null) {
                    rs.close();
                }
                // Statement를 닫는다.
                if (psmtQuery != null) {
                    psmtQuery.close();
                }
                if (psmtUpdate != null) {
                    psmtUpdate.close();
                }
                // Connection를 닫는다.
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }
    }
}