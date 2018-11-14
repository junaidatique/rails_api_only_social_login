# User.create({email: 'hello@positng.ly', name: 'Admin', password: 'test1234', role: :admin})

services_json = {
  twitter: {
    name: 'Twitter',    
    url: 'https://twitter.com',
    share_options: {
      'link' => 'Share as link',
      'share_one_image' => 'Share one image',
      'share_four_image' => 'Share four images',
    },
    service: [{ 
      name: 'Twitter Profile', 
      slug: 'twitter_profile',       
      character_limit: 280      
    }]
  },
  facebook: {
    name: 'Facebook',    
    url: 'https://facebook.com',
    share_options: {
      'link' => 'Share as link',
      'share_as_album' => 'Share as album',
      'share_as_timeline' => 'Share as timeline photo',
    },
    service: [ 
      { 
        name: 'Facebook Profile', 
        slug: 'facebook_profile',       
        character_limit: 0,
        can_schedule: false
      },
      { 
        name: 'Facebook Page', 
        slug: 'facebook_page',     
        character_limit: 5000
      },
      { 
        name: 'Facebook Group', 
        slug: 'facebook_group',     
        character_limit: 5000 
      },
    ]
  },
  linkedin: {
    name: 'Linkedin',
    url: 'https://linkedin.com',
    share_options: {
      'link': 'Share as link'
    },
    service: [
      { 
        name: 'Linkedin Profile', 
        slug: 'linkedin_profile',  
        character_limit: 700 
      },
      { 
        name: 'Linkedin Group', 
        slug: 'linkedin_group', 
        character_limit: 200 
      },
      { 
        name: 'Linkedin Page', 
        slug: 'linkedin_page', 
        character_limit: 700 
      }
    ]
  },
  pinterest: {
    name: 'Pinterest',    
    url: 'https://pinterest.com',
    share_options: {      
      'share_as_image' => 'Share image',      
    },
    service: [{ 
      name: 'Pinterest Profile', 
      slug: 'pinterest_profile',       
      character_limit: 500      
    }]
  },
  instagram: {
    name: 'Instagram',    
    url: 'https://instagram.com',
    share_options: {      
      'share_as_image' => 'Share image',      
    },
    service: [
      { 
        name: 'Instagram Profile', 
        slug: 'instagram_profile',         
        character_limit: 2200 
      },
      { 
        name: 'Instagram Business', 
        slug: 'instagram_business',         
        character_limit: 2200 
      },  
    ]
  },
  Buffer: {
    name: 'Buffer',    
    url: 'https://buffer.com',
    share_options: {      
      'share_as_link' => 'Share link',
    },
    service: [
      { 
        name: 'Buffer', 
        slug: 'buffer',         
        character_limit: 0,
        can_schedule: false 
      },
      { 
        name: 'Buffer Twitter Profile', 
        slug: 'buffer_twitter_profile', 
        character_limit: 280
      },
      { 
        name: 'Buffer Facebook Profile', 
        slug: 'buffer_facebook_profile', 
        character_limit: 0,
        can_schedule: false 
      },
      { 
        name: 'Buffer Facebook Page', 
        slug: 'buffer_facebook_page', 
        character_limit: 5000 
      },
      { 
        name: 'Buffer Facebook Group', 
        slug: 'buffer_facebook_group', 
        character_limit: 5000 
      },
      { 
        name: 'Buffer Linkedin Profile', 
        slug: 'buffer_linkedin_profile', 
        character_limit: 700 
      },
      { 
        name: 'Buffer Linkedin Group', 
        slug: 'buffer_linkedin_group', 
        character_limit: 200 
      },
      { 
        name: 'Buffer Linkedin Page', 
        slug: 'buffer_linkedin_page', 
        character_limit: 700 
      },
      { 
        name: 'Buffer Pinterest Profile', 
        slug: 'buffer_pinterest_profile', 
        character_limit: 500 
      },
      { 
        name: 'Buffer Instagram Profile', 
        slug: 'buffer_instagram_profile', 
        character_limit: 2200 
      },
      { 
        name: 'Buffer Instagram Business', 
        slug: 'buffer_instagram_business', 
        character_limit: 2200 
      }, 
      { 
        name: 'Buffer Google+ Profile', 
        slug: 'buffer_google_plus_profile', 
        character_limit: 5000 
      }, 
      { 
        name: 'Buffer Google+ Page', 
        slug: 'buffer_google_plus_page', 
        character_limit: 5000 
      }, 
    ]
  },
}

services_json.each do |platform, service_platform_object|
  service_object = service_platform_object[:service]
  service_platform_object.delete(:service)    
  service_platform = ServicePlatform.create!(service_platform_object)
  service_object.each do |service_object_option|
    service = Service.new(service_object_option)
    service.service_platform = service_platform
    service.save!
  end
end

services = Service.all
(1..5).each do |i|
  user = User.create!({email: Faker::Internet.email, name: Faker::Name.name , password: 'test1234', role: :customer})
  title = Faker::SiliconValley.company
  title_downcase = "#{title.gsub(' ', '-').downcase}";
  url = "#{title_downcase}.myshopify.com"
  currency = Faker::Currency.code
  symbol = Faker::Currency.symbol
  store = Store.create!(
    {
      title: title, 
      slug: Faker::Internet.slug,
      url: Faker::SiliconValley.url,
      partner_id: Faker::Number.number(10),
      partner_name: 'Shopify',
      partner_specific_url: url,
      partner_created_at: Faker::Date.backward(1 + rand(40)),
      partner_updated_at: Faker::Date.backward(1 + rand(40)),      
      uniq_key: "shopify-#{Faker::Number.number(10)}-#{Time.now.to_i}",
      description: Faker::Lorem.sentences(3),
      position: i,
      is_published: true,
      partner_token: Faker::String.random(64),
      timezone: Faker::Address.time_zone,      
      currency: currency,
      money_format: "#{symbol}{amount}",
      money_with_currency_format: "#{symbol}{amount} #{currency}",
      user_id: user.id
    }
  )
  parent_profile = nil
  services.each do |service|
    if service.slug == 'facebook_page' or service.slug == 'facebook_group'
      parent_profile = store.profiles.facebook_profile.first
    end
    profile = Profile.create!(
      {
        name: "#{title}",
        avatar_url: Faker::Avatar.image("64x64"),
        service_user_id: Faker::Number.number(10),
        service_username: title_downcase,
        formatted_username: title_downcase,
        url: Faker::Internet.url,
        access_token: Faker::String.random(64),
        access_token_secret: Faker::String.random(64),
        is_connected: Faker::Boolean.boolean,
        is_token_expired: Faker::Boolean.boolean,
        store: store.id,
        service: service.id,
        service_slug: service.slug,
        parent_profile: parent_profile
      }
    )
  end
  
  (1..4).each do |category_id|
    Category.create!(
      {
        title: Faker::Lorem.word,         
        slug: Faker::Internet.slug,
        url: Faker::Internet.url,
        partner_id: Faker::Number.number(10),
        partner_name: 'Shopify',
        partner_specific_url: Faker::Internet.url,
        partner_created_at: Faker::Date.backward(1 + rand(40)),
        partner_updated_at: Faker::Date.backward(1 + rand(40)),        
        uniq_key: "shopify-#{Faker::Number.number(10)}-#{Time.now.to_i}",
        description: Faker::Lorem.sentences(3),
        position: category_id,
        is_published: true,
        store_id: store.id
      }
    )
  end
  categories = store.categories.all
  categories.each do |category|
    (1..4).each do |product_id|
      product = Product.create!(
        {
          title: Faker::Lorem.word,         
          slug: Faker::Internet.slug,
          url: Faker::Internet.url,
          partner_id: Faker::Number.number(10),
          partner_name: 'Shopify',
          partner_specific_url: Faker::Internet.url,
          partner_created_at: Faker::Date.backward(1 + rand(40)),
          partner_updated_at: Faker::Date.backward(1 + rand(40)),        
          uniq_key: "shopify-#{Faker::Number.number(10)}-#{Time.now.to_i}",
          description: Faker::Lorem.sentences(3),
          position: product_id,
          is_published: true,
          store_id: store.id,
          quantity: rand(30),
          minimum_price: Faker::Number.decimal(3,2) * 100,    
          maximum_price: Faker::Number.decimal(3,2) * 100,    
          short_url: 'https://pooo.st'
        }
      )
      product.categories << category
      (1..4).each do |image_id|
        image = Image.create!(
          {        
            slug: Faker::Internet.slug,
            url: Faker::LoremFlickr.image,
            partner_id: Faker::Number.number(10),
            partner_name: 'Shopify',
            partner_specific_url: Faker::LoremFlickr.image,
            partner_created_at: Faker::Date.backward(1 + rand(40)),
            partner_updated_at: Faker::Date.backward(1 + rand(40)),        
            uniq_key: "shopify-#{Faker::Number.number(10)}-#{Time.now.to_i}",        
            position: image_id,
            is_published: true,
            imageable: product
            
          }
        )      
      end
      (1..4).each do |variant_id|
        variant = product.variants.create!(
          {
            title: Faker::Lorem.word,         
            slug: Faker::Internet.slug,
            url: Faker::Internet.url,
            partner_id: Faker::Number.number(10),
            partner_name: 'Shopify',
            partner_specific_url: Faker::Internet.url,
            partner_created_at: Faker::Date.backward(1 + rand(40)),
            partner_updated_at: Faker::Date.backward(1 + rand(40)),        
            uniq_key: "shopify-#{Faker::Number.number(10)}-#{Time.now.to_i}",
            description: Faker::Lorem.sentences(3),
            position: product_id,
            is_published: true,            
            price: Faker::Number.decimal(3,2) * 100,    
            original_price: Faker::Number.decimal(3,2) * 100,    
            quantity: rand(30),
            
          }
        )  
        product_image = product.images.offset(variant_id - 1).limit(1).first.clone
        product_image.imageable = variant
        product_image.save
      end
    end
  end

end