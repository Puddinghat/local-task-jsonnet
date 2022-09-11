local terraformResource(resource, phase=5) = {
  tf+: {
    [if phase == null then 'bootstrap' else 'phase-%s' % phase]+: [
      {
        resource+: resource,
      },
    ],
  },
};
local terraformData(data, phase=5) = {
  tf+: {
    [if phase == null then 'bootstrap' else 'phase-%s' % phase]+: [
      {
        data+: data,
      },
    ],
  },
};

local newNetwork(name, driver='bridge') = terraformResource(
  {
    docker_network: {
      [name]: {
        name: name,
        driver: driver,
      },
    },
  }
);

{
  local setup = self,
  tf: {
    'phase-5': [
      {
        terraform: {
          required_providers: {
            docker: {
              source: 'kreuzwerker/docker',
              version: '2.21.0',
            },
          },
        },
      },
    ],
  },
}
+
newNetwork('test')
