{ lib, beamPackages, overrides ? (x: y: {}) }:

let
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildErlangMk = lib.makeOverridable beamPackages.buildErlangMk;

  self = packages // (overrides self packages);

  packages = with beamPackages; with self; {
    castore = buildMix rec {
      name = "castore";
      version = "0.1.16";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0ldnwk9cwqm4f5hsgjvhq5ci7ics4azhmg2ibk9jap1vv11jrv98";
      };

      beamDeps = [];
    };

    earmark_parser = buildMix rec {
      name = "earmark_parser";
      version = "1.4.19";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0ifwm595kf0wywqbp6cqdp3hbhsf65688x8bjsiw6xaw1divcyjj";
      };

      beamDeps = [];
    };

    ex_doc = buildMix rec {
      name = "ex_doc";
      version = "0.28.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0c81vd45w0n5mwnh5hd86gaas7symkmj4wa7v37z9ld5d7gxlp75";
      };

      beamDeps = [ earmark_parser makeup_elixir makeup_erlang ];
    };

    jason = buildMix rec {
      name = "jason";
      version = "1.3.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1b620901micds3q2pfnwcp861hjiwx0wpyahgvnf142k4m8izz2k";
      };

      beamDeps = [];
    };

    makeup = buildMix rec {
      name = "makeup";
      version = "1.0.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1a9cp9zp85yfybhdxapi9haa1yykzq91bw8abmk0qp1z5p05i8fg";
      };

      beamDeps = [ nimble_parsec ];
    };

    makeup_elixir = buildMix rec {
      name = "makeup_elixir";
      version = "0.15.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0x9yhal7zngssyrgrm2gxq1d91phr51jpvackpsfyclvs14aw8zx";
      };

      beamDeps = [ makeup nimble_parsec ];
    };

    makeup_erlang = buildMix rec {
      name = "makeup_erlang";
      version = "0.1.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1fvw0zr7vqd94vlj62xbqh0yrih1f7wwnmlj62rz0klax44hhk8p";
      };

      beamDeps = [ makeup ];
    };

    nimble_parsec = buildMix rec {
      name = "nimble_parsec";
      version = "1.2.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0nadrz9a4jig365g909842jiw671r0dwjnz3vndbz5wcqc71vhr3";
      };

      beamDeps = [];
    };

    nx = buildMix rec {
      name = "nx";
      version = "0.1.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0mkjg0pm3c5mfv9kzga9w1zil44lx7xkp4j7qb3bgiy99lc6xki4";
      };

      beamDeps = [];
    };

    rustler = buildMix rec {
      name = "rustler";
      version = "0.25.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1x1w5yhcymlradxmrp34lykfgvfznlm11i489liwcygy6wda2hvb";
      };

      beamDeps = [ jason toml ];
    };

    rustler_precompiled = buildMix rec {
      name = "rustler_precompiled";
      version = "0.3.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0vjll2sfq7hbqcgsgnzjxyqvyvqvjv0rmy061b1kh9gabfpvlvc3";
      };

      beamDeps = [ castore rustler ];
    };

    toml = buildMix rec {
      name = "toml";
      version = "0.6.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1ykjlsjiq1w6kbmhyisjqygs2gmqx7lgaccdlck0qk6p4r8y84yh";
      };

      beamDeps = [];
    };
  };
in self

