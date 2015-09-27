# Place any code you want to run when the component is included on the client
# or server.

# To include code only on the client use:
# if RUBY_PLATFORM == 'opal'
#
# To include code only on the server, use:
# unless RUBY_PLATFORM == 'opal'
# ^^ this will not send compile in code in the conditional to the client.
# ^^ this include code required in the conditional.

unless RUBY_PLATFORM == 'opal'
require 'simplify'
# Simplify Commerce details https://www.simplify.com/commerce/app#/account/apiKeys

Simplify::public_key = "sbpb_Yjk4ZWI1MTItMzRhYy00ZTQwLWJmY2EtMjJhMTU3YTJiNTJh"
Simplify::private_key  = "yfu5mycOrMROsm9uzGmxGinLisSnqLgUSDoj4sIYhs55YFFQL0ODSXAOkNtXTToq"



end

# Site Settings
SITE_TAGLINE = "Give hope & purpose to refugees"

ADMIN_ID = "d9e2ff5f10e7437560c6bd69"

CATEGORIES = ["Housing", "Education", "Employment"]

# PLANS = ['10', '12.5']
PLANS = [ '$10/mo', '$12.5mo with Kutoa administration fees' ]

# Pojects / cases per page
CONST_PER_PAGE = 10
