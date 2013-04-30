require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MyHeritage < OmniAuth::Strategies::OAuth2

      option :client_options, {
        :site => 'https://accounts.myheritage.com',
        :authorize_url => '/oauth2/authorize',
        :token_url => '/oauth2/token'
      }

      option :authorize_params, {
        
      }

      option :name, 'myheritage'

      option :access_token_options, {
        :header_format => 'Bearer %s',
        :param_name => 'bearer_token'
      }
      
      option :authorize_options, [:scope]

      def request_phase
        super
      end

      def build_access_token
        token_params = {
          :code => request.params['code'],
          :redirect_uri => callback_url,
          :client_id => client.id,
          :client_secret => client.secret,
          :grant_type => 'authorization_code'
        }
        client.get_token(token_params)
      end
      
      uid { raw_info['id'] }
      
      info do
        prune!({
          'name'           => raw_info['name'],
        })
      end
      
      extra do 
        { 'profile' =>  prune!(raw_info) }
      end
      
      def raw_info
        @raw_info ||= access_token.get('https://familygraph.myheritage.com/me').parsed
      end

      def authorize_params
        super.tap do |params|
          params.merge!(:state => request.params['state']) if request.params['state']
          params[:scope] ||= 'email'
        end
      end

      private

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end

    end
  end
end

OmniAuth.config.add_camelization 'myheritage', 'MyHeritage'
