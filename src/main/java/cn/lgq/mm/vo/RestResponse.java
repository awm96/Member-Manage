package cn.lgq.mm.vo;

import lombok.Data;

@Data
public class RestResponse {

	/** 成功失败标识 */
	private boolean success;
	/** 返回的消息，失败时返回原因 */
	private String message;
	/** 调用返回的数据对象 */
	private Object data;

	public static RestResponse success() {
		RestResponse response = new RestResponse();
		response.setSuccess(true);
		return response;
	}

	public static RestResponse success(Object data) {
		RestResponse response = new RestResponse();
		response.setSuccess(true);
		response.setData(data);
		return response;
	}

	public static RestResponse failure(String message) {
		RestResponse response = new RestResponse();
		response.setMessage(message);
		return response;
	}
}
