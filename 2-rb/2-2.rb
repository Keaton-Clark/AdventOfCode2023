total = 0
File.foreach('input.txt') {|line| 
  line = line.split(':')
  gameno = line[0].scan(/\d/).join('').to_i
  possible = true
  green_max = 0
  red_max = 0
  blue_max = 0
  line[1].split(';').each {|set|
    set.split(',').each {|color|
      color = color.split
      if color[1].eql? 'blue'
        blue_max = [color[0].to_i, blue_max].max
      end
      if color[1].eql? 'red'
        red_max = [color[0].to_i, red_max].max
      end
      if color[1].eql? 'green'
        green_max = [color[0].to_i, green_max].max
      end
    }
  }
  total = total + (green_max * red_max * blue_max)
}
puts total
