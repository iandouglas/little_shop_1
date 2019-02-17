class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def total
    @contents.values.sum
  end

  def add_item(id)
    if @contents[id] == nil
      @contents[id] = 0
    end
    @contents[id] += 1
  end

  def all_items
    items = {}
    @contents.each { |item_id, quantity| items[Item.find(item_id)] = quantity}
    items
  end

  def subtotal(item)
    all_items[item] * item.price
  end

  def grand_total
    all_items.keys.sum {|item| subtotal(item)}
  end

  def update_items_quantity(type, id)
    item_stock = Item.find(id).quantity
    if type == 'add'
      @contents[id] += 1 unless item_stock == @contents[id]
    elsif type == 'remove'
      @contents[id] -= 1
    end
  end
end
