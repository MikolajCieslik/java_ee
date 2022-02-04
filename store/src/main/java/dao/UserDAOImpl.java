package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import model.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

public class UserDAOImpl implements UserDAO{

    private DataSource dataSource;
    private JdbcTemplate jdbcTemplate;

    @Override
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
        jdbcTemplate = new JdbcTemplate(this.dataSource);
    }

    @Override
    public int create(User user) {
        return 0;
    }

    @Override
    public List<User> read() {
        List<User> userList = jdbcTemplate.query("SELECT * from USERS", new RowMapper<User>() {

            @Override
            public User mapRow(ResultSet rs, int rowNum) throws SQLException {

                User user = new User();

                user.setImie(rs.getString("imie"));
                user.setNazwisko(rs.getString("nazwisko"));
                return user;
            }

        });
        return userList;
    }
}
