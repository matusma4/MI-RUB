class Node
  attr_accessor :id, :adj_nodes, :visited
  def initialize(id)
    @id = id
    @visited = false
    @adj_nodes = Array.new()
  end
end

class Graph
  attr_accessor :size, :nodes
  def initialize(size)
    @size = size
    @nodes = Array.new()
  end
  
  def dfs(node)
    node.visited = true
    print "#{node.id} "
    node.adj_nodes.each do |neighbor|
      dfs(neighbor) if neighbor.visited==false
    end
  end

  def bfs(start)
    queue = Array.new()
    queue.push(start)
    while queue.count > 0
      u = queue.pop()
      print "#{u.id} "
      u.visited = true
      u.adj_nodes.each do |neighbor|
        if(neighbor.visited==false)
          neighbor.visited = true
          queue.insert(0, neighbor)
        end
      end
    end
  end
  
end

class States
  GRAPH_NUM = 0
  NODES_COUNT = 1
  NODE_LINE = 2
  SEARCH_LINE = 3
end

state = States::GRAPH_NUM
actual_graph_num = 0
actual_node_num = 0
actual_graph_node_count = 0
graph = nil

File.open("input") do |file|
  while content = file.gets
    case state
    when States::GRAPH_NUM
      state = States::NODES_COUNT
    when States::NODES_COUNT
      actual_graph_node_count = content.to_i()
      graph = Graph.new(actual_graph_node_count)
      puts "graph #{actual_graph_num+1}"
      actual_graph_node_count.times { |i| graph.nodes.push(Node.new(i+1)) }
      actual_graph_num += 1
      state = States::NODE_LINE
      
    when States::NODE_LINE
      node = graph.nodes.at(actual_node_num)
      #print "doing node: #{graph.nodes.at(actual_node_num).id}: "
      line = content.split(' ')
      line[1] = 0
      line.each { |n|
        if(actual_node_num+1!=n.to_i() && n.to_i()!=0)
          node.adj_nodes.push(graph.nodes.at(n.to_i()-1))
          #print "n=#{graph.nodes.at(n.to_i()-1).id} "
        end
      }
      actual_node_num += 1
      state = States::NODE_LINE
      if(actual_node_num==actual_graph_node_count)
        state = States::SEARCH_LINE
        actual_node_num = 0
      end

    when States::SEARCH_LINE
      search = content.split(' ')
      if("0"==search[0])
        state = States::NODES_COUNT
      else
        graph.nodes.each do |node|
          node.visited = false
        end
        case search[1]
        when "0"
          graph.dfs(graph.nodes.at(search[0].to_i()-1))
          puts " "
        when "1"
          graph.bfs(graph.nodes.at(search[0].to_i()-1))
          puts " "
        end
        state = States::SEARCH_LINE
      end


    end
  end
end






