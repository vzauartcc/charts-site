# Charts Site

Quick reference FAA charts for the airports inside ZAU's airspace. Inspired by [BVA's charts site](https://charts.bvartcc.com) and [vZOA's Charts Site Generator](https://github.com/vzoa/charts-site-generator).

FAA chart data is fetched client side at render from [aviationapi.com](https://www.aviationapi.com/), eliminating the need for continuous maintenance/building.

All content is served from a single, static HTML file, with Tailwind CSS for styling. Node.JS is used for compiling the styles to a static CSS file.

---

# Deploying to GitHub pages

This project can be set up to automatically build and deploy via a GitHub Action. The repository must be set up under the Pages setting to use GitHub Actions as the build source.

# Deploying to Cloudflare Pages

This project can be set up to automatically build and deploy via Cloudflare Pages. Create a new Cloudflare Pages application, and use GitHub to connect it to the repository. Set the build command to:

```bash
chmod +x build.sh && ./build.sh
```

and set the build output to `_site`.

# Load Balancing between GitHub Pages and Cloudflare Pages

A very simple load balancer between GitHub Pages and Cloudflare Pages can be created by a Cloudflare Worker.

```javascript
export default {
	async fetch(request) {
		const origins = [
			'https://charts-site.pages.dev/', // Your Cloudflare Pages URL
			'https://vzauartcc.github.io/charts-site/', // Your GitHub Pages URL
		];

		// Pick a random origin
		const target = origins[Math.floor(Math.random() * origins.length)];

		// Redirect to the randomly selected origin
		return Response.redirect(target, 302);
	},
};
```

You can use the worker URL for accessing the charts site, either via a CNAME record or anchor tag.
