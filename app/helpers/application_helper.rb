module ApplicationHelper
  def simple_time(time)
    time.strftime("%Y/%m/%d　%H:%M　")
  end

  def simpler_time(time)
    time.strftime("%H:%M")
  end
end
