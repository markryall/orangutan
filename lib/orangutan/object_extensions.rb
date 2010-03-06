class Object
  def eigen
    class << self
      self
    end
  end
  
  def eigen_eval(&block)
    eigen.instance_eval(&block)
  end
end