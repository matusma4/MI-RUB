class Rectangle
  attr_accessor :a, :xc, :yc
  def initialize(a, xc, yc)
    @a = isvalidedge(a)
    @xc = checkinput(xc)
    @yc = checkinput(yc)
  end

  def isvalidedge(edge)
    e = checkinput(edge)
    if(e < 0)
      puts "Spatny vstup"
      return false
    end
    e
  end

  def checkinput(input)
    if(!isnumeric(input))
      puts "Spatny vstup"
      return false
    end
    Float(input)
  end

  def isnumeric(input)
    true if Float(input) rescue false
  end
end

class Rectangles_Solver
  attr_accessor :a, :b
  def initialize(a, b)
    @a = a
    @b = b
  end

  def getover(b1, e1, b2, e2)
    i1 = Float(b1-e1/2)..Float(b1+e1/2)
    i2 = Float(b2-e2/2)..Float(b2+e2/2)
    if(!i1.include?(i2.first) && !i1.include?(i2.last) && !i2.include?(i1.last) && !i2.include?(i1.first))
      return 0
    end
    if(i2.include?(i1.last) && i2.include?(i1.first))
      return i1.last-i1.first
    end
    if(i1.include?(i2.first))
      if(!i1.include?(i2.last))
        return i1.last-i2.first
      end
      return i2.last-i2.first
    end
    if(i1.include?(i2.last))
      return i2.last-i1.first
    end
    return 0
  end

  def getuserinput
    print "Zadejte delku hrany prvniho ctverce: "
    e1 = gets.chomp

    print "Zadejte x-ovou souradnici stredu prvniho ctverce: "
    x1 = gets.chomp

    print "Zadejte y-ovou souradnici stredu prvniho ctverce: "
    y1 = gets.chomp

    print "Zadejte delku hrany druheho ctverce: "
    e2 = gets.chomp

    print "Zadejte x-ovou souradnici stredu druheho ctverce: "
    x2 = gets.chomp

    print "Zadejte y-ovou souradnici stredu druheho ctverce: "
    y2 = gets.chomp

    @a = Rectangle.new(e1, x1, y1)
    @b = Rectangle.new(e2, x2, y2)
  end

  def solve
    if(!check())
      return false
    end
    x_over = getover(@a.xc, @a.a, @b.xc, @b.a)
    y_over = getover(@a.yc, @a.a, @b.yc, @b.a)
    if(x_over==0 || y_over==0)
      puts "Ctverce se ani nedotykaji."
      return false
    end

    res = (@a.a*@a.a + @b.a*@b.a) - x_over*y_over
    puts "Obsah sjednoceni dvou ctvercu je #{res}"
    return res
  end

  def check
    if(!@a.a || !@a.xc || !@a.yc || !@b.a || !@b.xc || !@b.yc)
      return false
    end
    return true
  end
 
end
