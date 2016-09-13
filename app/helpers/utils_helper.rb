module UtilsHelper
  def human_time_diff(from, to)
    seconds = to - from

    distance_of_time_in_words_to_now(seconds.seconds.ago)
  end
end
