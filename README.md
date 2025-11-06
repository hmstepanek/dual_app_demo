# dual_app_demo
Creates two python flask apps that talk to each other. One is running with CAT enabled and the other is running on a feature branch with CAT completely removed.

1. First create and export the New Relic staging license key and make sure you are connected to the VPN.
   `export NEW_RELIC_LICENSE_KEY=24ac**NRAL`
1. Run the following:
   ```
   git submodule update --init --recursive
   docker compose build
   docker compose up -d
   ```
1. Then go to your browser and access: `http://localhost:5000/`. Note the first request
   will be slow as this blocks while the agent connects to New Relic. You may need to
   refresh several times and wait up to 6 minutes for the data to show up in the APM
   `Dual App 1 CAT` and `Dual App 2 CAT Removed` entities under the distributed tracing tab.

