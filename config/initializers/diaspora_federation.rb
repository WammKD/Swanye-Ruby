DiasporaFederation.configure do |config|
  # the pod url
  config.server_uri = URI("http://localhost:3000")

  # ... other settings

  config.define_callbacks do
    on :fetch_person_for_webfinger do |diaspora_id|
      person = Person.find_local_by_diaspora_id(diaspora_id)

      if person
        DiasporaFederation::Discovery::WebFinger.new(
          # ... copy person attributes to WebFinger object
        )
      end
    end

    on :fetch_person_for_hcard do |guid|
      # ... fetch hcard information
    end

    # ... other callbacks
    on :save_person_after_webfinger do |person|
      # ... save person
    end

    on :fetch_private_key do |diaspora_id|
      person = Person.find_local_by_diaspora_id(diaspora_id)

      if person
        # ... fetch private OpenSSL::PKey::RSA key?
      end
    end

    on :fetch_public_key do |diaspora_id|
      person = Person.find_local_by_diaspora_id(diaspora_id)

      if person
        # ... fetch person's OpenSSL::PKey::RSA key
      end
    end

    on :fetch_related_entity do |entity_type,  # (Post, Comment, Like, etc)
                                 guid|
      # ... find DiasporaFederation::Entities::RelatedEntity objects
    end

    on :queue_public_receive do |xml,     # salmon slap xml or magic envelope xml
                                 legacy|  # true  if it is a legacy salmon slap,
                                          # false if it is a magic envelope xml
      # ... queue a public salmon xml to process in background
    end

    on :queue_private_receive do |guid,         # guid of the receiver person
                                  xml_or_json,  # salmon slap xml or encrypted magic envelope json
                                  legacy|       # true  if it is a legacy salmon slap,
                                                # false if it is a encrypted magic envelope json
      # ... return true if successful, false if the user was not found
    end

    on :receive_entity do |entity, recipient_id|
      # ... receive
    end

    on :fetch_public_entity do |entity_type,  # (Post, StatusMessage, etc)
                                guid|
      # ... fetch
    end

    on :fetch_person_url_to do |diaspora_id, path|
      # ... fetch the url to path for a person
    end

    on :update_pod do |url, status|
      # ... update the pod status
    end
  end
end
