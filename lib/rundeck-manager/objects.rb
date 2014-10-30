module RundeckManager
  module Objects
    Dir[File.expand_path('../objects/*.rb', __FILE__)].each { |f| require f }

    include Jobs
  end
end
