class JsonFileHelper
  def self.read_json file
    file = File.read(file)
    JSON.parse(file)
  end

  def self.generate_json data, path
  	File.delete(path) if File.file?(path)
    File.open(path, 'w') do |f|
      f.write( JSON.pretty_generate(data) )
    end
  end
end