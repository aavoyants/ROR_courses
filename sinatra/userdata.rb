class Userdata
  include DataMapper::Resource

  property :id, Serial
  property :ip, String
  property :time, DateTime
end

DataMapper.finalize

def savedata
  Userdata.create :ip => request.ip, :time => DateTime.now
end