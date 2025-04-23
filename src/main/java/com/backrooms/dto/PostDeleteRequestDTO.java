package com.backrooms.dto;

import java.util.List;

public class PostDeleteRequestDTO {
	
	//@NotNull: TODO: list가 null이거나 lengthrk 0인경우에대한 에러처리 추가하기
	//프론트에서 선택한 게시글 없이 삭제버튼을 누를때, ajax 삭제 요청이 안되게 막았지만
	//talend와 같은 API 테스터로 요청하는경우에는 에러가 발생함. 누군가 이런 요청을하면 서버가 다운되기때문에 이 경우들에대한 에러처리가 필요함. 
	//핸들러가 실행기되전 파라미터 바인딩이 되는 시점에서 발생할수 있는 타입 미스매치나 다른 에러에대한 처리가 필요함. 
    private List<Integer> list;
    
    public PostDeleteRequestDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PostDeleteRequestDTO(List<Integer> list) {
		super();
		this.list = list;
	}

	public List<Integer> getList() {
		return list;
	}

	public void setList(List<Integer> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "DeleteRequestDTO [list=" + list + "]";
	}

}
