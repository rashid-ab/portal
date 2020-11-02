class Login < ApplicationRecord

    enum login_type: [ "SFTP or FTP", "Domain Registrar", "Social Media Account", "Other"  ]

    belongs_to :company
end
