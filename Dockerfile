FROM --platform=${BUILDPLATFORM} rust:1.67 AS build
WORKDIR /work

RUN rustup target add wasm32-wasi

COPY Cargo.lock Cargo.toml ./
RUN mkdir src \
	&& echo "fn main() {print!(\"Dummy main\");} // dummy file" > src/main.rs
RUN cargo build --locked --target wasm32-wasi --release && rm -f ./target/wasm32-wasi/release/*.wasm

COPY . ./
RUN cargo build --frozen --target wasm32-wasi --release

FROM scratch
COPY --from=build /work/target/wasm32-wasi/release/hello-world-repeater.wasm .
COPY --from=build /work/spin.toml .
