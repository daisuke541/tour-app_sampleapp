class User < ApplicationRecord
    
    has_many:posts
    
    name,presence:true
    email,presence:true
end
