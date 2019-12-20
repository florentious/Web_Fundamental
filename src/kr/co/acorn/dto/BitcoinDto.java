package kr.co.acorn.dto;

public class BitcoinDto {
	private String date;
	private float open;
	private float high;
	private float low;
	private float close;
	private long volume;
	private long marketCap;
	
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public float getOpen() {
		return open;
	}
	public void setOpen(float open) {
		this.open = open;
	}
	public float getHigh() {
		return high;
	}
	public void setHigh(float high) {
		this.high = high;
	}
	public float getLow() {
		return low;
	}
	public void setLow(float low) {
		this.low = low;
	}
	public float getClose() {
		return close;
	}
	public void setClose(float close) {
		this.close = close;
	}
	public long getVolume() {
		return volume;
	}
	public void setVolume(long volume) {
		this.volume = volume;
	}
	public long getMarketCap() {
		return marketCap;
	}
	public void setMarketCap(long marketCap) {
		this.marketCap = marketCap;
	}
	
	
	public BitcoinDto(String date, float open, float high, float low, float close, long volume, long marketCap) {
		this.date = date;
		this.open = open;
		this.high = high;
		this.low = low;
		this.close = close;
		this.volume = volume;
		this.marketCap = marketCap;
	}
	
	
	
	
	
	
}
