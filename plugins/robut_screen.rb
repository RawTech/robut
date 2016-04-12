class Robut::Plugin::Screen
  include Robut::Plugin

  REGEX_CHANGE_SCREEN = /^screen \D+ \D+ \d+/

  def usage
    [
     "#{at_nick} screen <screen-name> <view-name> <duration>"
    ]
  end

  def handle(time, sender_nick, message)
    return unless sent_to_me?(message)

    case without_nick(message)
    when REGEX_CHANGE_SCREEN
      messageParts = without_nick(message).split(" ")
      screenName = messageParts[1]
      viewName = messageParts[2]
      duration = messageParts[3]
      durationI = duration.to_i

      if durationI < 5
        reply "Duraton must be more than 4 seconds"
        return
      end

      if durationI > 120
        reply "Duration cannot be more than 120 seconds"
        return
      end

      open("http://dev-tools.wrenkitchens.com:3000/api/switch/#{screenName}/#{viewName}/#{duration}");
      reply "Changed #{screenName} to #{viewName} for #{duration} seconds!"
    end
  end
end
