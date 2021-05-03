require 'pry'
require 'csv'

class Gossip
  attr_accessor :author, :content, :id

  def initialize(id = '', author, content)
    @author = author
    @content = content
    @id = id
  end

  def save
    CSV.open('./db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    id = 1
    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(id, csv_line[0], csv_line[1])
      id += 1
    end
    all_gossips
  end

  def self.find(id)
    all[id - 1]
  end

  def self.update(id, gossip_author_update, gossip_content_update)
    all_gossips = all
    all_gossips[id].content = gossip_content_update
    all_gossips[id].author = gossip_author_update
    File.open('./db/gossip.csv', 'w') { |file| file.truncate(0) }
    all_gossips.each do |gossip|
      gossip.save
    end
  end
end
