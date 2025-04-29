from jumpstarter.config.client import ClientConfigV1Alpha1
from jumpstarter.common.utils import env
from contextlib import ExitStack
from robot.api import Error


class JumpstarterLibrary:
    """Robot Framework library for interacting with Jumpstarter devices."""

    # Don't re-create this library for each test case
    ROBOT_LIBRARY_SCOPE = "SUITE"

    def __init__(self):
        self._stack = ExitStack()
        self._client = None
        self._console = None
        self._lease = None

    def request_lease(self, selector=None, client="default"):
        try:
            self._client = self._stack.enter_context(env())
        except RuntimeError:
            selector = getattr(self, "selector", None)
            config = ClientConfigV1Alpha1.load(alias=client)
            self._lease = self._stack.enter_context(config.lease(selector=selector))
            self._client = self._stack.enter_context(self._lease.connect())

    def release_lease(self):
        self._stack.close()

    def power_cycle(self):
        self._client.power.cycle()
        # Re-create the console after power cycle
        self._console = self._stack.enter_context(self._client.console.pexpect())

    def console_send(self, send_text, times=1):
        if self._console is None:
            raise Error("Console not available")
        self._console.sendline(send_text * times)

    def console_expect(self, expect_text, timeout=10):
        if self._console is None:
            raise Error("Console not available")
        self._console.expect_exact(expect_text, timeout=timeout)

    def console_get_output(self):
        if self._console is None:
            raise Error("Console not available")
        return self._console.before.decode()
