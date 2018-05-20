# CarrierWave.configure do |config|
#       config.fog_provider = 'fog/aws'
#       config.fog_credentials = {
#         provider: 'AWS',
#         aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#         aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
#         region: 'us-west-1',
#         endpoint: 'https://s3.amazonaws.com'
#       }
#       config.fog_directory = ENV['S3_BUCKET']
#       config.fog_public = false
#       config.storage = :fog
#       config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } 

#     if Rails.env.development? || Rails.env.test? 
#         config.storage = :file
#         config.enable_processing = false
#         config.root = "#{Rails.root}/tmp"
#     else
#       config.storage = :fog
#     end
#   end
#   def module CarrierWave
#     def module MiniMagic
#       def quality(percentage) 
#         manipulate! do |img|
#           img.quality(percentage.to_s)
#           img = yield(img) if block_given
#           img
#         end  
#       end  
#     end    
#   end
