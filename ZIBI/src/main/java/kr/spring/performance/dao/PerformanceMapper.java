package kr.spring.performance.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.performance.vo.CinemaVO;
import kr.spring.performance.vo.PerformanceVO;
import kr.spring.performance.vo.TicketingVO;

@Mapper
public interface PerformanceMapper {
	// 사용자
	public List<PerformanceVO> selectList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	@Select("SELECT cinema_location1 FROM cinema GROUP BY cinema_location1")
	public List<CinemaVO> selectCinemaLoc1();
	public List<CinemaVO> selectCinemaLoc2(Map<String, Object> map);
	@Select("SELECT cinema_num FROM cinema WHERE cinema_location2=#{cinema_location2}")
	public List<CinemaVO> selectCinemaNum(String cinema_location2);
	@Select("SELECT * FROM ticketing WHERE cinema_num=#{cinema_num}")
	public List<TicketingVO> selectPerformance(int cinema_num);
	@Select("SELECT DISTINCT ticketing_date FROM ticketing")
	public List<TicketingVO> selectDate();
	
	// 상영관 + 날짜로 예매할 수 있는 정보 출력
	@Select("SELECT c.cinema_theater FROM ticketing t, performance p, cinema c WHERE t.performance_num=p.performance_num AND t.cinema_num=c.cinema_num AND t.cinema_num=#{cinema_num} AND t.ticketing_date=#{day}")
	public List<CinemaVO> selectCinemaWithTicketing(int cinema_num, String day);
	@Select("SELECT p.performance_title, p.performance_poster, p.performance_age FROM ticketing t, performance p, cinema c WHERE t.performance_num=p.performance_num AND t.cinema_num=c.cinema_num AND t.cinema_num=#{cinema_num} AND t.ticketing_date=#{day}")
	public List<PerformanceVO> selectPerformanceWithTicketing(int cinema_num, String day);
	@Select("SELECT t.ticketing_num,t.performance_num,t.cinema_num,t.ticketing_date,t.ticketing_start_time FROM ticketing t, performance p, cinema c WHERE t.performance_num=p.performance_num AND t.cinema_num=c.cinema_num AND t.cinema_num=#{cinema_num} AND t.ticketing_date=#{day}")
	public List<TicketingVO> selectWithTicketing(int cinema_num, String day);
	
	// 상영관 + 날짜 + 영화로 예매할 수 있는 정보 출력
	
	
	
	// 관리자
	public void insertPerformance(PerformanceVO performance); // 영화 정보 저장
	public void insertCinema(CinemaVO cinema); // 상영관 정보 저장
	@Select("SELECT * FROM cinema WHERE cinema_location1=#{loc1}")
	public List<CinemaVO> selectLocation2(String loc1);
	public void insertDate(TicketingVO ticketing);
	
}
