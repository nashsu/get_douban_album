#!/usr/bin/ruby
require 'rubygems'
require 'open-uri'
require 'nokogiri'


album_link = ARGV.first.gsub(/\?start=.*/,"").strip


#相册连接
page = Nokogiri::HTML(open(album_link, "User-Agent" => "Safari"))


#获取相册长度

album_page_count = page.css('span.thispage').last['data-total-page'].to_i

(0..(album_page_count-1)).each do |page_number|

	link = "#{album_link}?start=#{page_number * 18}"

	page = Nokogiri::HTML(open(link, "User-Agent" => "Safari"))

	page.css('a.photolst_photo').each do |x| 
		img =	x.children().last['src'].to_s.gsub("thumb","large")
		system("wget #{img} 2>&1 > /dev/null")
	end

end
