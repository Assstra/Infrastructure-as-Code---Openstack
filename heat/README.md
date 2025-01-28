# Heat as orchestrator

Heat is the orchestration service for OpenStack. It allows users to define and manage the entire lifecycle of infrastructure and applications within OpenStack clouds using templates. These templates, written in YAML, describe the resources (such as servers, floating IPs, volumes, security groups, etc.) and their relationships, enabling automated and repeatable deployments. Heat simplifies the process of managing complex cloud applications by providing a way to automate resource provisioning and configuration.

If needed, you can use openstack CLI to find flavors and images available in your project:

```bash
❯ openstack image list
+--------------------------------------+------------------+--------+
| ID                                   | Name             | Status |
+--------------------------------------+------------------+--------+
| 049ceb7e-b2c1-41fe-ab4d-83dc55f731b8 | <redacted>       | active |
| 88c323fd-5052-4fec-9166-38cf10f8fa19 | <redacted>       | active |
+--------------------------------------+------------------+--------+

❯ openstack flavor list
+--------------------------------------+-------------------+-------+------+-----------+-------+-----------+
| ID                                   | Name              |   RAM | Disk | Ephemeral | VCPUs | Is Public |
+--------------------------------------+-------------------+-------+------+-----------+-------+-----------+
| 0bb896b0-3e44-47d9-b478-017ac1008498 | <redacted>        | 16096 |   50 |         0 |     8 | True      |
| 29683739-1d6f-40b7-81c9-c209fcb1ddd3 | <redacted>        |  8192 |  100 |         0 |     2 | True      |
+--------------------------------------+-------------------+-------+------+-----------+-------+-----------+
```

Here are the command to deploy a simple application infrastructure on Openstack:

```bash
openstack stack create <stack_name> -f yaml -t simple_app_template.yaml --parameter key_name=<key_pair> --parameter flavor=<flavor_id> --parameter image=<image_name> --parameter name=<name>
```

With the following parameters:

- `key_name`: The name of the key pair to use for SSH access to the instances.
- `flavor`: The flavor ID specifying the compute, memory, and storage capacity of the instances.
- `image`: The name or ID of the image to use for the instances.
- `name`: The name to assign to the stack.
