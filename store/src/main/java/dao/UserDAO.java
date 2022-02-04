package dao;

import java.util.List;
import javax.sql.DataSource;
import model.User;

public interface UserDAO {
    public void setDataSource(DataSource dataSource);
    public int create(User user);
    public List<User> read();
}
