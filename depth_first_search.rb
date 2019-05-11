頂点
class Vertex
end

#枝
class Edge
  def initialize(s, e)
    @s = s    #始点
    @e = e    #終点
  end
  attr_reader :e
end

#グラフ
class Graph
  def initialize(vs, h)    #hはHash
    @vs = vs    #Array:頂点（要素は Vertex）
    @es = {}    #Hash:枝（Vertex=>Array）:Arrayの要素はEdge
    h.each_key do |k|
      @es[k] = []
      h[k].each {|e| @es[k] << Edge.new(k, e)}
    end
  end
  
  def get_edges(v)
    @es[v]    #頂点vからのすべての枝（Array）を返す
  end
  
  #goalを見つければtrue, 見つけられなければfalseを返す
  def find(start, goal) 
    dfs(start, goal, [])
  end
  
  def dfs(v, goal, visited)
    return true if v == goal
    return false if visited.include?(v)
    visited << v
    return false unless (edges = get_edges(v))
    edges.each {|edge| return true if dfs(edge.e, goal, visited)}
    false
  end
end

vs = [1, 2, 3, 4, 5, 6, 7]
eh = {1=>[2, 5, 7], 2=>[3, 4], 5=>[4, 6], 6=>[4]}
g = Graph.new(vs, eh)

vs.each {|v| p g.get_edges(v)}; puts
1.upto(7) {|i| print "#{g.find(5, i)}  "}; puts