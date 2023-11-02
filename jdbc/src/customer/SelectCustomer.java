package customer;

import conf.Conf;
import java.sql.*;

public class SelectCustomer {

    public static void main(String[] args) {

        Connection conn = null;
        PreparedStatement psmtQuery = null;
        ResultSet rs = null;

        try {
            // 드라이버를 로딩한다.
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // 데이터베이스의 연결을 설정한다.
            conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD);

            // 고객 정보를 검색한다
            // TODO 전체 고객 정보 검색문 완성
            String query = "SELECT * FROM customer";
            // TODO 고객아이디로 특정 고객을 검색하는 검색문 완성
            // String query = "SELECT * FROM customer WHERE customer_id = ?";

            // Statement를 가져온다.
            psmtQuery = conn.prepareStatement(query);
            // 특정 고객을 위한 고객아이드 설정\
            // 아래 숫자 1은 query에서 "첫 번째 물음표"라는 의미
            // psmtQuery.setString(1, "apple");

            // SQL문을 실행한다.
            rs = psmtQuery.executeQuery();

            // 결과 집합의 내용을 출력한다.
            while (rs.next()) {

                String customerId = rs.getString("customer_id");
                String customerName = rs.getString("customer_name");
                int age = rs.getInt("age");
                String grade = rs.getString("grade");
                String jobTitle = rs.getString("job_title");
                int savedMoney = rs.getInt("saved_money");

                System.out.printf("%-12s : %3s : %3d : %-6s : %-3s : %5d %n"
                        , customerId, customerName, age, grade, jobTitle, savedMoney);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally { // 가비지 컬렉션 --> Garbage Collection
            try {
                // ResultSet를 닫는다.
                if (rs != null) {
                    rs.close();
                }
                // Statement를 닫는다.
                if (psmtQuery != null) {
                    psmtQuery.close();
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