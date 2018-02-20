class SearchesController < ApplicationController

  def new
    # @search_term = params['q']
  end

  def show
    @job_title = params['q']
    @location = params['l']

    @response = HTTParty.get("https://www.indeed.com/jobs?q=#{@job_title}&l=#{@location}")

    if @response.present?
      @dom = Nokogiri::HTML(@response.body)
      @jobs = @dom.css('.jobtitle')
      @summary = @dom.css('.summary')
      @company = @dom.css('.company')
    end

    @a = []
    @b = []
    @c = []

    i = 0
    @jobs.each do |job|
      @a << {title: @jobs[i].text.gsub(/([\n])/,"").strip,
      summary: @summary[i].text.gsub(/([\n])/,"").strip,
       company: @company[i].text.gsub(/([\n])/,"").strip }
      i += 1
    end

  end
end
