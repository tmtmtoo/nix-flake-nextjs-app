/** @type {import("syncpack").RcFile} */
const config = {
  source: '**/package.json',
  versionGroups: [
    {
      label: 'Local Version Group',
      dependencies: ['my-math'],
      dependencyTypes: ['local'],
    },
  ],
};

module.exports = config;
