require 'sinatra'
require 'data_mapper'
require 'sinatra'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/contacts_list.db")

class Email
  include DataMapper::Resource
    property :id, Serial
    property :content, Text, :required => true
    property :email, Text, :required => true
    property :created, DateTime
    property :done, Boolean, :required => true, :default => false
   
end
  
  DataMapper.finalize.auto_upgrade!
  Email.create(content: "Test budget", email: "haris@hotmail.com", created: Time.now)
  Email.create(content: "Test budget2", email: "haris123@hotmail.com", created: Time.now)

get '/' do 
  @emails = Email.all(:order => :created.desc)
  redirect '/new' if @emails.empty?
  erb :index
end