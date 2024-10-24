module BeanUtils
  class EmailDomains
    def self.blocklist
      @blocklist ||= Rails.cache.fetch("bean_utils/email_domains/blocklist", expires_in: 1.days) do
        # read config/email_domain_blocklist.conf from engine config path
        blocklist = File.read(BeanUtils::Engine.root.join("config/email_domain_blocklist.conf")).split("\n").compact
        blocklist.present? ? blocklist : nil
      end
      @blocklist || []
    end

    def self.whitelist
      @whitelist ||= Rails.cache.fetch("bean_utils/email_domains/whitelist", expires_in: 1.days) do
        # read config/email_domain_allowlist.conf from engine config path
        whitelist = File.read(BeanUtils::Engine.root.join("config/email_domain_allowlist.conf")).split("\n").compact
        whitelist.present? ? whitelist : nil
      end
      @whitelist || []
    end

    def self.in_blocklist?(email)
      blocklist.include?(email.split('@')[1])
    end

    def self.in_whitelist?(email)
      whitelist.include?(email.split('@')[1])
    end
  end
end
