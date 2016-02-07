class AddBookmarkFromExtension

  def self.create_bookmark(list_id, bookmark_name, url)

    list = List.find(list_id)
    existing_bookmark = Bookmark.find_by(name: bookmark_name, url: url)

    #############################################################################
    ## The following is a FIRST PASS at not pushing duplicate snapshots up to S3.
    #############################################################################

    if existing_bookmark
      existing_snapshot = Snapshot.find_by(bookmark_id: existing_bookmark.id)
      book_id = [existing_bookmark.id]
      new_bookmark = existing_bookmark
      new_snapshot = Snapshot.new(existing_snapshot.attributes.merge({:id => Snapshot.count+1}))
      new_snapshot.save
    else
      new_bookmark = Bookmark.new(name: bookmark_name, url: url)
      new_bookmark.save
      book_id = [new_bookmark.id]
      GetThumbnails.call(book_id)
    end
    saved_bookmark = SavedBookmark.create(list_id: list.id, bookmark_id: new_bookmark.id)
  end

end