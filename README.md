newRelic Cookbook
=================
This cookbooks delivers the New Relic Monitoring agent for servers based on the operating system (Windows and RHEL actually).

Requirements
------------
a chef server... the dependency cookbooks for windows etc. 

Attributes
----------

Usage
-----
Add the license key into the recipe per OS and then just include `newRelic` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[newRelic]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Christian Johannsen, 2014 
