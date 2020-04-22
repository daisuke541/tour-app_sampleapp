if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      
      :provider              => 'AWS',
      :region                => ENV['ap-northeast-1'],     
      :aws_access_key_id     => ENV['AKIASRPO3AMG45WMI5PV'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['toyappdaisuke']
  end
end