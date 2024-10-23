> # Documentation

### `Get` Basic info

```bash
  GET /api/
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/
```

> #### No parameter required ❌

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get("https://https://anime0002.vercel.app/api/");
console.log(resp.data);
```

### `Get` Top 10 anime's info

```bash
  GET /api/top-ten
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/info?id={string}
```

> #### No parameter required ❌

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/top-ten"
);
console.log(resp.data);
```

### `Get` specified anime's info

```bash
  GET /api/info
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/info?id={string}
```

#### Parameters

| Parameter |  Type  | Description | Mandatory ? | Default |
| :-------: | :----: | :---------: | :---------: | :-----: |
|   `id`    | string |  anime-id   |   Yes ✔️    |   --    |

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/info?id=yami-shibai-9-17879"
);
console.log(resp.data);
```

### `Get` random anime's info

```bash
  GET /api/random
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/random
```

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/random"
);
console.log(resp.data);
```

### `Get` several categories info

```bash
  GET /api/<category>
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/{string}?page={number}
  #or
  https://https://anime0002.vercel.app/api/{string}
```

#### Parameters

| Parameter  | Parameter-type | Data-type | Description | Mandatory ? | Default |
| :--------: | :------------: | :-------: | :---------: | :---------: | :-----: |
| `category` |     `path`     | `string`  | `Category`  |   Yes ✔️    |   --    |
|   `page`   |    `query`     | `number`  | `Page-no.`  |    No ❌    |   `1`   |

#### List of Categories

- top-airing
- most-popular
- most-favorite
- completed
- recently-updated
- recently-added
- top-upcoming
- subbed-anime
- dubbed-anime
- top-upcoming
- movie
- special
- ova
- ona
- tv

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/most-popular?page=1"
);
console.log(resp.data);
```

### `Get` search result's info

```bash
  GET /api/search
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/search?keyword={string}
```

#### Parameters

| Parameter | Parameter-type |   Type   | Description | Mandatory ? | Default |
| :-------: | :------------: | :------: | :---------: | :---------: | :-----: |
| `keyword` |    `query`     | `string` |  `keyword`  |   Yes ✔️    |   --    |

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/search?keyword=one%20punch%20man"
);
console.log(resp.data);
```

### `Get` suggestions

```bash
  GET /api/search
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/search/suggest?keyword={string}
```

#### Parameters

| Parameter | Parameter-type |   Type   | Description | Mandatory ? | Default |
| :-------: | :------------: | :------: | :---------: | :---------: | :-----: |
| `keyword` |    `query`     | `string` |  `keyword`  |   Yes ✔️    |   --    |

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/search/suggest?keyword=demon"
);
console.log(resp.data);
```

### `Get` anime's episode list

```bash
  GET /api/episodes/
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/episode/{param}
```

#### Parameters

| Parameter |  Type  | Description | Mandatory ? | Default |
| :-------: | :----: | :---------: | :---------: | :-----: |
|  `param`  | string |  anime-id   |   Yes ✔️    |   --    |

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/episodes/one-piece-100"
);
console.log(resp.data);
```

### `Get` schedule of upcoming anime

```bash
  GET /api/schedule
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/schedule?date={string}
```

#### Parameters

| Parameter |  Type  | Description | Mandatory ? | Default |
| :-------: | :----: | :---------: | :---------: | :-----: |
|  `query`  | string |  anime-id   |   Yes ✔️    |   --    |

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/schedule?date=2024-09-23"
);
console.log(resp.data);
```

### `Get` servers list

```bash
  GET /api/servers/
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/schedule?date={string}
```

#### Parameters

| Parameter |  Type  | Description | Mandatory ? | Default |
| :-------: | :----: | :---------: | :---------: | :-----: |
| `params`  | string |  anime-id   |   Yes ✔️    |   --    |

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/servers/demon-slayer-kimetsu-no-yaiba-hashira-training-arc-19107?ep=124260"
);
console.log(resp.data);
```

### `Get` streaming info

```bash
  GET /api/stream
```

### Endpoint

```bash
  https://https://anime0002.vercel.app/api/stream?id={string}
```

#### Parameters

| Parameter | Parameter-type |   Type   | Description | Mandatory ? | Default |
| :-------: | :------------: | :------: | :---------: | :---------: | :-----: |
|   `id`    |    `query`     | `string` |  `keyword`  |   Yes ✔️    |   --    |

#### Example of request

```javascript
import axios from "axios";
const resp = await axios.get(
  "https://https://anime0002.vercel.app/api/stream?id=frieren-beyond-journeys-end-18542?ep=107257"
);
console.log(resp.data);
```
