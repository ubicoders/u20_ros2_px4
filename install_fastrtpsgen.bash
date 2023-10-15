# install java_home
apt-get update && apt-get install -y \
  openjdk-11-jdk \
  && rm -rf /var/lib/apt/lists/*

echo "JAVA_HOME=\"/usr/lib/jvm/java-11-openjdk-amd64\"" >> /etc/environment

# installing fastrtpsgen for px4
pip3 install -U empy pyros-genmsg setuptools
git clone --recursive https://github.com/eProsima/Fast-DDS-Gen.git -b v1.0.4 /tmp/Fast-DDS-Gen
cd /tmp
cd /tmp/Fast-DDS-Gen/gradle/wrapper
distributionUrl=https\://services.gradle.org/distributions/gradle-6.8.3-bin.zip
cd /tmp/Fast-DDS-Gen
./gradlew assemble && env "PATH=$PATH" ./gradlew install
echo FASTRTPSGEN installed at: $(which fastrtpsgen)
