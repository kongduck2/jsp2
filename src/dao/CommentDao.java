package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.Comment;
import dto.Freeboard;
import mybatis.SqlSessionBean;

public class CommentDao {
	private static CommentDao dao = new CommentDao();
	private CommentDao() {}
	public static CommentDao getInstance() {
		return dao;
	}
	
	SqlSessionFactory sqlFactory = SqlSessionBean.getSessionFactory();
	
	public List<Comment> getComments(int mref) { 
		List<Comment> list =null;
		SqlSession mapper = sqlFactory.openSession();
		list = mapper.selectList("getComments",mref);
		mapper.close();
		return list;
	}
	
	public void insert(Comment dto) {
		SqlSession mapper = sqlFactory.openSession();
		mapper.insert("comment.insert",dto);
		//mapper xml 파일에 지정되어 있는 namespace로 똑같은 파일명 구분해주기
		mapper.commit();
		mapper.close();
	}
	
	public void updateCountAll(int idx) {
		SqlSession mapper = sqlFactory.openSession();
		mapper.update("updateCountAll", idx);
		mapper.commit();
		mapper.close();
	}
	
	public void updateCommentCnt(int idx) {
		SqlSession mapper = sqlFactory.openSession();
		mapper.update("updateCommentCnt", idx);
		mapper.commit();
		mapper.close();
	}
	public void deleteComment(int idx) {
		SqlSession mapper = sqlFactory.openSession();
		mapper.delete("comment.deleteComment",idx);
		mapper.commit();
		mapper.close();
	}
}
