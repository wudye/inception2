FROM debian:bullseye-slim
# it is generally recommended to use the latest stable release with the slim variant for a balance of stability, security, and efficiency

# The -y flag is used with apt-get install to automatically answer "yes" to any prompts during the installation process.
RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

# In summary, this RUN command in the Dockerfile generates a self-signed SSL certificate and private key using OpenSSL. The certificate is valid for 365 days and uses a 4096-bit RSA key with SHA-256 hashing. The generated certificate and key are saved to /etc/nginx/ssl/mwu.pem and /etc/nginx/ssl/mwu.key, respectively. This setup is useful for securing communications with an Nginx server running inside the Docker container, ensuring that data transmitted between the server and clients is encrypte
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/mwu.pem \
	-keyout /etc/nginx/ssl/mwu.key \
	-subj "/C=AT/ST=Vienna/O=42/OU=42/CN=mwu.42.fr"


RUN mkdir -p /run/nginx
# ./conf/nginx.conf: This is the source path on the host machine. 
# /etc/nginx/http.d: This is the destination path in the Docker container.
#  this COPY instruction in the Dockerfile copies the nginx.conf file from the ./conf directory on the host machine to the /etc/nginx/http.d directory inside the Docker image.
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf


# CMD when you want to provide default behavior that can be changed. Use ENTRYPOINT when you want to ensure that a specific command is always run.
# CMD ["nginx", "-g", "daemon off;"]
ENTRYPOINT ["nginx", "-g", "daemon off;"]