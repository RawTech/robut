class Robut::Plugin::Pub
  include Robut::Plugin

  REGEX_TAKE_ORDERS = /^take pub orders$/
  REGEX_LIST_ORDERS = /^list pub orders$/
  REGEX_ADD_ORDER = /^add pub order (.+)/

  def usage
    [
     "#{at_nick} take pub orders - start taking orders",
     "#{at_nick} list pub orders - lists orders",
     "#{at_nick} add pub order - adds your order"
    ]
  end

  def handle(time, sender_nick, message)
    return unless sent_to_me?(message)

    case without_nick(message)
    when REGEX_TAKE_ORDERS
      store["orders"] = Hash.new
      reply "@here now taking orders for the pub!"
    when REGEX_LIST_ORDERS
      return if store["orders"].empty?

      reply "here are the orders dollface"
      store["orders"].each do |person, order|
        reply "#{person} ordered: #{order}"
      end
    when REGEX_ADD_ORDER
      add_order(sender_nick, without_nick(message).match(REGEX_ADD_ORDER)[1])
      reply "#{sender_nick}, thanks for the order ;)"
    end
  end

  def add_order(person, order)
    store["orders"][person] = order
  end
end
