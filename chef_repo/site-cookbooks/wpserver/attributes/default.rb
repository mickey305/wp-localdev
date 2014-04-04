
#
#
# copy to wordpress/wp-config.php
default['wpserver']['db']['database'] = 'wordpress_db'
default['wpserver']['db']['user']     = 'wp_user'
default['wpserver']['db']['pass']     = 'wp_password'

#
#
#
#
#
#
# default
default['wpserver']['db']['host']         = 'localhost'
default['wpserver']['db']['rootpass']     = ''
default['wpserver']['db']['old-rootpass'] = ''
default['wpserver']['db']['store-days']   = 14


default['wpserver']['tmp-file']['sql']['path'] = '/tmp/sql_file/'


default['wpserver']['save-content']['name'] = []


default['wpserver']['into']['nonspace'] = ''
default['wpserver']['into']['colon'] = ':'

default['wpserver']['ht-permission']['order']['true']  = 'order allow,deny'
default['wpserver']['ht-permission']['order']['false'] = 'order deny,allow'
default['wpserver']['ht-permission']['true']           = 'allow'
default['wpserver']['ht-permission']['false']          = 'deny'
default['wpserver']['ht-permission']['permit-from']    = 'allow from '



default['wpserver']['randomstr']['code']['num'] = 8
default['wpserver']['randomstr']['code']['len'] = 64

















require 'timeout'

require 'digest/sha1'
require 'date'
require 'openssl'



def init_flag
	return false

end

def set_flag
	return true

end

# function : to create unique code
def wp_generate_uniquecodekey(leng)

	seed = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a
	other = [
		'!','#','$','%','&','(',')','-','=','^',
		'~','|','@','`','[','{',';','+',':','*',
		']','}',',','<','.','>','/','?','_',' '
	]
	seed += other
	char =''

	while (char.length < leng)
		char += seed[rand(seed.length)].to_s
	end

	return char
end


# function : to make list with unique code
def wp_uniquecodekey_listing(num,len)

	# prepare the number and length of the code for making a calculation
	wordpress_Massofcode_Num    = num
	wordpress_Massofcode_Length = len



	array_pass = Array.new(wordpress_Massofcode_Num)
	array_pass[0] = wp_generate_uniquecodekey(wordpress_Massofcode_Length)

	now_point = 1

	begin

		timeout(10) {
			loop {
				# include unique code
				tmp = wp_generate_uniquecodekey(wordpress_Massofcode_Length)
				# initialize flags
				push_flag = init_flag
				find_flag = init_flag


				for j in 0..now_point-1 do
					if array_pass[j] == tmp then
						find_flag = set_flag
					end
				end

				if !find_flag then
					push_flag = set_flag
				end

				if push_flag then
					array_pass[now_point] = tmp
					now_point += 1

				end




				if now_point > array_pass.length-1 then
					break
				end
			}
		}

	rescue Timeout::Error
		# put error log
		print "\e[31m"
		puts "--------- timeout error happened"
		puts "--------- please check a variable or running time in the ruby file \"generatecodekey.rb\""
		print "\e[0m"
	end



	return array_pass
end




def sha1_hash16
	salt = "gew3-ec?od;e*~U9n, /.13GDIK"
	# return Digest::SHA1.hexdigest(wp_generate_uniquecodekey(16)+salt)
	return Digest::SHA1.hexdigest(OpenSSL::Random.random_bytes(16)+salt)
end







# generate code
#
list = wp_uniquecodekey_listing(default['wpserver']['randomstr']['code']['num'],default['wpserver']['randomstr']['code']['len'])

# define Wordpress Unique keys
#
# default['wpserver']['wp']['key-auth']    = list[0]
# default['wpserver']['wp']['key-secure']  = list[1]
# default['wpserver']['wp']['key-logged']  = list[2]
# default['wpserver']['wp']['key-nonce']   = list[3]
# default['wpserver']['wp']['salt-auth']   = list[4]
# default['wpserver']['wp']['salt-secure'] = list[5]
# default['wpserver']['wp']['salt-logged'] = list[6]
# default['wpserver']['wp']['salt-nonce']  = list[7]
default['wpserver']['wp']['key-auth']    = list[0] + sha1_hash16
default['wpserver']['wp']['key-secure']  = list[1] + sha1_hash16
default['wpserver']['wp']['key-logged']  = list[2] + sha1_hash16
default['wpserver']['wp']['key-nonce']   = list[3] + sha1_hash16
default['wpserver']['wp']['salt-auth']   = list[4] + sha1_hash16
default['wpserver']['wp']['salt-secure'] = list[5] + sha1_hash16
default['wpserver']['wp']['salt-logged'] = list[6] + sha1_hash16
default['wpserver']['wp']['salt-nonce']  = list[7] + sha1_hash16
#
# default['wpserver']['wp']['salt-nonce']  = [OpenSSL::Random.random_bytes(64)].pack('m') #+ "-" + sha1_hash16







