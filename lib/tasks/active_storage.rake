namespace :active_storage do
  desc "Move files from paperclip folders to active_storage locations"
  task transfer_attachments: :environment do
    class ActiveStorageBlob < ActiveRecord::Base
    end

    class ActiveStorageAttachment < ActiveRecord::Base
      belongs_to :blob, class_name: 'ActiveStorageBlob'
      belongs_to :record, polymorphic: true
    end

    ActiveStorageAttachment.find_each do |attachment|
      name = attachment.name

      source = attachment.record.send(name).path
      dest_dir = File.join(
        "storage",
        attachment.blob.key.first(2),
        attachment.blob.key.first(4).last(2))
      dest = File.join(dest_dir, attachment.blob.key)

      FileUtils.mkdir_p(dest_dir)
      puts "Moving #{source} to #{dest}"
      FileUtils.cp(source, dest)
    end
  end
end
