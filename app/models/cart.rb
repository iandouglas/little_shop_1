class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def total
    @contents.values.sum
  end

  def add_item(id)
    @contents[id] += 1
  end

end
