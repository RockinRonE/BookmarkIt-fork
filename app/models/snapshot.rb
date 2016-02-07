class Snapshot < ActiveRecord::Base
  has_many :bookmarks      ### HAS MANY IN ORDER TO REDUCE DUPLICATION OF IMAGES

  has_attached_file :thumbnail, styles: {
    # thumb: '100x100>',
    # square: '200x200#',
    # medium: '300x300>'
  }

  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/

end
