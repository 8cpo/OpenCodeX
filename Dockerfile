FROM oven/bun:1.4.4-alpine

ARG BUN_RUNTIME_TRANSPILER_CACHE_PATH=0
ENV BUN_RUNTIME_TRANSPILER_CACHE_PATH=${BUN_RUNTIME_TRANSPILER_CACHE_PATH}

RUN apk add --no-cache git libgcc libstdc++ ripgrep

WORKDIR /app
COPY . .
RUN bun install --frozen-lockfile

RUN mkdir -p /root/.local/share/opencode /root/.config/opencode

LABEL org.opencontainers.image.source=https://github.com/8cpo/OpenCodeX
LABEL org.opencontainers.image.description="OpenCodeX coding agent"

ENTRYPOINT ["bun", "run", "--cwd", "packages/cli", "src/index.ts"]
CMD ["--help"]
