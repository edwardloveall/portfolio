# Source: https://github.com/thoughtbot/paperclip/blob/master/MIGRATING.md#copy-the-database-data-over
Dir[Rails.root.join("app/models/**/*.rb")].sort.each { |file| require file }

class ConvertToActiveStorage < ActiveRecord::Migration[5.2]
  require 'open-uri'

  def up
    get_blob_id = 'LASTVAL()'

    active_storage_blob_sql = <<-SQL
      INSERT INTO active_storage_blobs (
        key, filename, content_type, metadata, byte_size, checksum, created_at
      ) VALUES ($1, $2, $3, '{}', $4, $5, $6)
    SQL

    active_storage_attachment_sql = <<-SQL
      INSERT INTO active_storage_attachments (
        name, record_type, record_id, blob_id, created_at
      ) VALUES ($1, $2, $3, #{get_blob_id}, $4)
    SQL

    models = ActiveRecord::Base.descendants.reject(&:abstract_class?)

    transaction do
      db = ActiveRecord::Base.connection.raw_connection
      models.each do |model|
        attachments = model.column_names.map do |c|
          if c =~ /(.+)_file_name$/
            $1
          end
        end.compact

        model.find_each.each do |instance|
          attachments.each do |attachment|
            db.exec_params(
              active_storage_blob_sql,
              [
                key(instance, attachment),
                instance.send("#{attachment}_file_name"),
                instance.send("#{attachment}_content_type"),
                instance.send("#{attachment}_file_size"),
                checksum(instance.send(attachment)),
                instance.updated_at.iso8601
              ]
            )

            db.exec_params(
              active_storage_attachment_sql,
              [attachment, model.name, instance.id, instance.updated_at.iso8601]
            )
          end
        end
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

  private

  def key(instance, attachment)
    SecureRandom.uuid
  end

  def checksum(attachment)
    url = attachment.path
    Digest::MD5.base64digest(File.read(url))
  end
end
